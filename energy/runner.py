import os
import subprocess

if __name__ == '__main__':
    files = []
    for directory in ['llama', 'human']:
        for root, dirs, filenames in os.walk(f'./energy/{directory}'):
            for file in filenames:
                if '.DS_Store' in file or '.cpp' in file:
                    continue
                files.append(os.path.join(root, file))
    print(files)