ARG1=$1  #M
ARG2=$2  #W
ARG3=$3  #W

CFGFILE=RSGravitonToGluonGluon_W-${ARG3}_M_${ARG1}_TuneCUETP8M1_13TeV_pythia8_cfi.py
rm ${CFGFILE}

cat >> ${CFGFILE}<<EOF99
import FWCore.ParameterSet.Config as cms

from Configuration.Generator.Pythia8CommonSettings_cfi import *
from Configuration.Generator.Pythia8CUEP8M1Settings_cfi import *

generator = cms.EDFilter("Pythia8GeneratorFilter",
        comEnergy = cms.double(13000.0),
        crossSection = cms.untracked.double(0.00000136),
        filterEfficiency = cms.untracked.double(1),
        maxEventsToPrint = cms.untracked.int32(0),
        pythiaHepMCVerbosity = cms.untracked.bool(False),
        pythiaPylistVerbosity = cms.untracked.int32(1),
        PythiaParameters = cms.PSet(
                pythia8CommonSettingsBlock,
                pythia8CUEP8M1SettingsBlock,
                processParameters = cms.vstring(
                        'ExtraDimensionsG*:gg2G* = on',
                        'ExtraDimensionsG*:kappaMG = ${ARG2}',
                        '5100039:m0 = ${ARG1}',
                        '5100039:onMode = off',
                        '5100039:onIfAny = 21'
                ),
                parameterSets = cms.vstring('pythia8CommonSettings',
                                            'pythia8CUEP8M1Settings',
                                            'processParameters',
                                            )
        )
)

ProductionFilterSequence = cms.Sequence(generator)

EOF99
echo "" >> ${CFGFILE}
