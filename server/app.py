from flask import Flask
import Monsoon.HVPM as HVPM
import Monsoon.sampleEngine as sampleEngine
import Monsoon.Operations as op

V_OUT = 5.0
CAL_TIME = 1250
GRANULARITY = 1

Mon = HVPM.Monsoon()
Mon.setup_usb()
Mon.setVout(V_OUT)
# Mon.setMaximumCurrent(3.5)
engine = sampleEngine.SampleEngine(Mon)
engine.ConsoleOutput(True)

app = Flask(__name__)
# ms = MonsoonService()

@app.post('/start/<filename>')
def start(filename):
    if filename == '':
        return 'Filename not provided', 400

    print(f'Starting sampling for {filename}')
    engine.enableCSVOutput(f"{filename}.csv")
    # samples = sampleEngine.SampleEngine.SAMPLECOUNT_INFINITE # no limit to samples
    engine.startSampling(
        calTime=CAL_TIME, 
        granularity=GRANULARITY)
    return 'OK'

@app.post('/stop')
def stop():
    print('Stopping sampling')
    engine.disableCSVOutput() # Closes and writes the CSV file
    Mon.stopSampling()
    return 'OK'


if __name__ == '__main__':
    app.run(debug=True)