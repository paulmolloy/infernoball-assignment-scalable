# Paul Molloy 2018
# CS7ns1 Scalable Computing.
import os,sys,argparse,tempfile,shutil
import base64
from Crypto.Cipher import AES
from hashlib import sha256
import secretsharing as sss
import jsonpickle 
# usage
def usage():
    print>>sys.stderr, "Usage: " + sys.argv[0] + "-i <infernoball_path> -p <potfile_path> "
    sys.exit(1)

def pxor(pwd,share):
    '''
      XOR a hashed password into a Shamir-share

      1st few chars of share are index, then "-" then hexdigits
      we'll return the same index, then "-" then xor(hexdigits,sha256(pwd))
      we truncate the sha256(pwd) to if the hexdigits are shorter
      we left pad the sha256(pwd) with zeros if the hexdigits are longer
      we left pad the output with zeros to the full length we xor'd
    '''
    words=share.split("-")
    hexshare=words[1]
    slen=len(hexshare)
    hashpwd=sha256(pwd).hexdigest()
    hlen=len(hashpwd)
    outlen=0
    if slen<hlen:
        outlen=slen
        hashpwd=hashpwd[0:outlen]
    elif slen>hlen:
        outlen=slen
        hashpwd=hashpwd.zfill(outlen)
    else:
        outlen=hlen
    xorvalue=int(hexshare, 16) ^ int(hashpwd, 16) # convert to integers and xor 
    paddedresult='{:x}'.format(xorvalue)          # convert back to hex
    paddedresult=paddedresult.zfill(outlen)       # pad left
    result=words[0]+"-"+paddedresult              # put index back
    return result



def pwds_shares_to_secret(kpwds,kinds,diffs):
    '''
        take k passwords, indices of those, and the "public" shares and 
        recover shamir secret
    '''
    shares=[]
    for i in range(0,len(kpwds)):
        shares.append(pxor(kpwds[i],diffs[kinds[i]]))
    secret=sss.SecretSharer.recover_secret(shares)
    return secret

# decrypt the cipher text given the key.
def decrypt(enc, key):
    enc = base64.b64decode(enc)
    iv = enc[:16]
    cipher = AES.new(key, AES.MODE_CBC, iv)
    return unpad(cipher.decrypt(enc[16:]))


unpad = lambda s: s[:-ord(s[len(s) - 1:])]


def main(argv):
    argparser=argparse.ArgumentParser(description='Get hashes out of a infernoball level')
    argparser.add_argument('-p','--potfile_path',     
                    dest='potfile_path',
                    help='path_for_the_potfile')

    argparser.add_argument('-i','--infernoball_path',     
                    dest='infernoball_path',
                    help='Path to the infernoball file.')
    
    args=argparser.parse_args()

    if args.infernoball_path is None:
        usage()
    if args.potfile_path is None:
        usage()

 
     # read  potfile
    d = {}
    with open(args.potfile_path) as pot_file:
        content = pot_file.read();
        for l in content.splitlines(True):
            arr = l.strip().split(':')
            if len(arr) != 2:
                print('Invalid potfile: Should have single \':\' separating the hash and password on each line.')
                return 0
            d[arr[0]] = arr[1]
   
    # read inferno ball file
    shares = []
    passwords = []
    with open(args.infernoball_path) as inferno_file:
        content = inferno_file.read();
        level = jsonpickle.decode(content)
        for i in range(len(level['hashes'])):
            h =  level['hashes'][i]
            if  h in d:
                shares.append(level['shares'][i].encode('ascii','ignore'))
                passwords.append(d[h].encode('ascii','ignore'))
            else:
                print(h + ' not in d')
    print('Got {} shares.').format(len(shares)) 
    if len(shares) == 0:
        print('Got no shares, maybe check formatting. Quiting.')
        return 0
    # print('Passwords: ', passwords)
    # print('Shares: ', shares)
    kinds = [i for i in xrange(len(passwords))]
    levelsecret=pwds_shares_to_secret(passwords,kinds,shares)   
    print("Got level secret:" +  levelsecret)
    print("Decrypted next level:")
    try:
        print(decrypt(level['ciphertext'], levelsecret.zfill(32).decode('hex')))
    except Exception as e:
        print >>sys.stderr, 'Exception decrypting level: The secret is probably wrong because you need to crack more hashes. ' + str(e)
        sys.exit(5)




if __name__ == "__main__":
    main(sys.argv)
