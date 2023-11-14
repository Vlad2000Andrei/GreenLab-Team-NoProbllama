import os
import subprocess

if __name__ == '__main__':
    files = []
    for directory in ['llama', 'human']:
        for root, dirs, filenames in os.walk(f'./energy/{directory}'):
            for file in filenames:
                filepath = os.path.join(root, file)
                filename = file.split('.')[0]
                if '.cpp' in filepath:
                    print(filepath)
                    proc = subprocess.Popen(['g++', '-std=c++20', filepath, '-o', filepath[:-4]], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
                    for line in proc.stdout:
                        print(line.decode('utf-8').rstrip())
                    proc.wait()
