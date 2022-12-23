# Script to fix xmls in case "Sample" isn't written - happens if 0 events in a region
import sys
import os

if len(sys.argv)==1: hf_output='./'
else:
	hf_output = sys.argv[1]
	if hf_output[-1]!='/':
		hf_output+='/'

regions = {
	'Sig_recast_signal_SRHMEM_mct2':'hrecast_signalNom_SRHMEM_obs_mct2',
	'Sig_recast_signal_SRMMEM_mct2':'hrecast_signalNom_SRMMEM_obs_mct2',
	'Sig_recast_signal_SRLMEM_mct2':'hrecast_signalNom_SRLMEM_obs_mct2',
	'Sig_recast_signal_STCREM_cuts':'hrecast_signalNom_STCREM_obs_cuts',
	'Sig_recast_signal_TRHMEM_cuts':'hrecast_signalNom_TRHMEM_obs_cuts',
	'Sig_recast_signal_TRMMEM_cuts':'hrecast_signalNom_TRMMEM_obs_cuts',
	'Sig_recast_signal_TRLMEM_cuts':'hrecast_signalNom_TRLMEM_obs_cuts',
	'Sig_recast_signal_WREM_cuts':'hrecast_signalNom_WREM_obs_cuts',
}

# function to make string of stuff to add to xml file
def add_stuff(region):
	stuff = '  <Sample Name="recast_signal" HistoName="'+regions[region]+'" InputFile="data/OneLeptonbb_HM_MM_LM_general_onlysignal.root" NormalizeByTheory="True">\n    <StatError Activate="True"/>\n    <NormFactor Name="mu_SIG" Val="1" High="5" Low="0" Const="False" />\n  </Sample>\n\n'
	return stuff

for region in regions:
	file_path = hf_output+'config/OneLeptonbb_HM_MM_LM_general_onlysignal/'+region+'.xml'
	lines = []
	with open(file_path,'r') as xmlfile:
		N = 0
		for line in xmlfile:
			lines.append(line)
			if 'Sample' in line:
				N+=1
	if N==0:
		print('WARNING: '+region+' has 0 events so xmls are broken. Xmls are being fixed by fix_xml.py script.')
		with open(file_path,'w') as xmlfile:
			for i in range(0, len(lines)):
				xmlfile.write(lines[i])
				if "StatErrorConfig" in lines[i-1]:
					xmlfile.write(add_stuff(region))
