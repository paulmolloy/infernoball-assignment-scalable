# Paul Molloy 2018
# CS7ns1 Scalable Computing.
import os,sys,argparse,tempfile,shutil

import jsonpickle 
# usage
def usage():
    print( "Usage: " + sys.argv[0] + "-i <infernoball_path> [-D <destdir>]  [-h <hashesfileName>] ",  file=sys.stderr)
    sys.exit(1)


def main(argv):
    argparser=argparse.ArgumentParser(description='Get hashes out of a infernoball level')
    argparser.add_argument('-D','--destdir',     
                    dest='destdir',
                    help='directory for output file')

    argparser.add_argument('-H','--dst_hashes_file_name',     
                    dest='dst_hashes_file_name',
                    help='filename for current level potfile.')

    argparser.add_argument('-i','--infernoball_path',     
                    dest='infernoball_path',
                    help='Path to the infernoball file.')
    
    args=argparser.parse_args()

    if args.infernoball_path is None:
        usage()


    destdir="."
    if args.destdir is not None:
        destdir=args.destdir

    if not os.access(destdir,os.W_OK):
# not checking we can write to destdir but feck it, good enough:-)
        print( "Can't access " + destdir + " - exiting")
        sys.exit(3)

# create a tmpdir and go there
    tmpdir=tempfile.mkdtemp()

# Ensure the file is read/write by the creator only
    saved_umask = os.umask(0o077)

    
    # read file
    with open(args.infernoball_path) as inferno_file:
        content = inferno_file.read();
        level = jsonpickle.decode(content)
        if  args.dst_hashes_file_name is None:
            for h in level['hashes']:
                print(h)
        else:
            fname=args.dst_hashes_file_name+".hashes"

            path=os.path.join(tmpdir,fname)
            print('Writing hashes to file: ' + destdir + "/" + fname)
            with open(path,"w") as tmpf:
                for h in level['hashes']:
                    tmpf.write("%s\n" % h)
            tmpf.close()
            shutil.move(path,destdir+"/"+fname)

if __name__ == "__main__":
    main(sys.argv)
