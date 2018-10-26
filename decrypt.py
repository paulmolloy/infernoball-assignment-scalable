# Paul Molloy 2018
# CS7ns1 Scalable Computing.
import os,sys,argparse,tempfile,shutil

import jsonpickle 
# usage
def usage():
    print( "Usage: " + sys.argv[0] + "-i <infernoball_path> -p <potfile_path ",  file=sys.stderr)
    sys.exit(1)


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
    with open(args.potfile_path) as pot_file:
        content = pot_file.read();
        for l in content.splitlines(True):
            print(l)
    print("infernoball hashes below:")
   
    # read inferno ball file
    with open(args.infernoball_path) as inferno_file:
        content = inferno_file.read();
        level = jsonpickle.decode(content)
        for h in level['hashes']:
            print(h)


if __name__ == "__main__":
    main(sys.argv)
