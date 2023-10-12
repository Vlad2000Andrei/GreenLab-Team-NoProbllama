# File of utility functions for monsoon control

import Monsoon.HVPM as HVPM
import Monsoon.sampleEngine as sampleEngine
import Monsoon.Operations as op

V_OUT = 4.7

class MonsoonService:
    engine = None
    is_running = False

    def setup_monsoon(self, calibrationTime=1250, granularity=1, console=False):
        Mon = HVPM.Monsoon()
        Mon.setup_usb()
        Mon.setVout(V_OUT)
        Mon.setMaximumCurrent(3.5)
        self.calibrationTime = calibrationTime
        self.granularity = granularity
        self.engine = sampleEngine.SampleEngine(Mon)
        self.engine.ConsoleOutput(console)

    def check_is_running(self):
        return self.is_running

    def start_sampling(self, filename):
        self.is_running = True
        self.engine.enableCSVOutput(f"{filename}.csv")
        samples = sampleEngine.SampleEngine.SAMPLECOUNT_INFINITE # no limit to samples
        self.engine.startSampling(
            calTime=self.calibrationTime, 
            granularity=self.granularity,
            samples=samples,
            filename=filename)

    def stop_sampling(self):
        self.engine.disableCSVOutput() # Closes and writes the CSV file
        self.engine.stopSampling()
        self.is_running = False