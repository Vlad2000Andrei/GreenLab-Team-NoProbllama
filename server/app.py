from flask import Flask
from monsoon_service import MonsoonService

app = Flask(__name__)
ms = MonsoonService()

@app.post('/start/<filename>')
def start(filename):
    if filename == '':
        return 'Filename not provided', 400

    print(f'Starting sampling for {filename}')
    ms.start_sampling('test')
    return 'OK'

@app.post('/stop')
def stop():
    if not ms.check_is_running():
        return 'Server not currently sampling', 400

    print('Stopping sampling')
    ms.stop_sampling()
    return 'OK'


if __name__ == '__main__':
    ms.setup_monsoon()
    app.run(debug=True)