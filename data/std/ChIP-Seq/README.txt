Sample ChIP-Seq peak data
Human embryonic stem cell ChIP-Seq data

ChIP-Seq peak data is downloaded from ENCODE. We select top 3000 sequences with the highest signal values, and retrieved 500 bases around each peak summit as positive sequences. Then for each positive sequence a corresponding negative sequence of the same length and the same triplet frequencies was generated randomly using a 2nd order Markov model. So the sample data files have 6000 sequences each - 3000 positive, 3000 negative. Each sequence has 500 bp. 

Link to the raw data from ENCODE:
http://ftp.ebi.ac.uk/pub/databases/ensembl/encode/integration_data_jan2011/byDataType/peaks/jan2011/peakSeq/optimal/peakSeq.optimal.wgEncodeHaibTfbsK562Gata2cg2Pcr1xAlnRep0_vs_wgEncodeHaibTfbsK562ControlV0416101AlnRep0.narrowPeak.gz
http://ftp.ebi.ac.uk/pub/databases/ensembl/encode/integration_data_jan2011/byDataType/peaks/jan2011/peakSeq/optimal/peakSeq.optimal.wgEncodeHaibTfbsH1hescNanogsc33759V0416102AlnRep0_vs_wgEncodeHaibTfbsH1hescControlPcr1xAlnRep0.narrowPeak.gz

'*_hybrid.txt' has additional 3000 background samples from peak shifting. For each positive peak, we shift +5000 bp as control sequence. Thus for each positive sample, there are 2 coresponding control samples, one from random model, the other from peak-shifting. 