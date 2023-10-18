import os
import subprocess

if __name__ == '__main__':
    files = []
    for directory in ['llama', 'human']:
        for root, dirs, filenames in os.walk(f'./energy/{directory}'):
            for file in filenames:
                filepath = os.path.join(root, file)
                filename = file.split('.')[0]
                if filepath.endswith('.cpp'):
                    proc = subprocess.Popen(f'g++ -std=x++20 {filepath} -o {filename}', shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                    proc.wait()