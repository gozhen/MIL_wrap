# [Computational modeling of in vivo and in vitro protein-DNA interactions by multiple instance learning](https://academic.oup.com/bioinformatics/article/33/14/2097/3059139)
Source code repository

Authors: Zhen Gao (zhen.gao@utsa.edu ) and Jianhua Ruan (jianhua.ruan@utsa.edu)

### Abstract
**Motivation**: The study of transcriptional regulation is still difficult yet fundamental in molecular biology research. While the development of both in vivo and in vitro profiling techniques have significantly enhanced our knowledge of transcription factor (TF)-DNA interactions, computational models of TF-DNA interactions are relatively simple and may not reveal sufficient biological insight. In particular, supervised learning based models for TF-DNA interactions attempt to map sequence-level features (k-mers) to binding event but usually ignore the location of $k$-mers, which can cause data fragmentation and consequently inferior model performance. 

**Results**: Here, we propose a novel algorithm based on the so-called multiple-instance learning (MIL) paradigm. MIL breaks each DNA sequence into multiple overlapping subsequences and models each subsequence separately, therefore implicitly takes into consideration binding site locations, resulting in both higher accuracy and better interpretability of the models. The result from both in vivo and in vitro TF-DNA interaction data show that our approach significantly outperforms conventional single-instance learning based algorithms. Importantly, the models learned from in vitro data using our approach can predict in vivo binding with very good accuracy. In addition, the location information obtained by our method provides additional insight for motif finding results from ChIP-Seq data. Finally, our approach can be easily combined with other state-of-the-art TF-DNA interaction modeling methods.


### Guide of usage
This program needs MATLAB version 8.6; Statistics and Machine Learning Toolbox 10.1

To Run, open MATLA, cd into this directory. 
Open demo scripts 'eg1_find_top_subSeqs.m' and 'eg2_core_funs.m', then run through the script.

```eg1_find_top_subSeqs.m```: 
  Guide through generating top instances from ChIP-Seq peaks/PBM probe sequences, generating standard sample file for MIL algorithm, generating binding models, and, predicting instance scores. 
	
```eg2_core_funs.m```: 
  Guide through bacis functions of our MIL approach.



```data/peak_from_encode_in_fa/```: 
  Sample ChIP-Seq peak file in fasta format.

```data/models/ChIP-seq/```: 
  495 models from ENCODE ChIP-Seq data.

```data/models/PBM/```:
  86 models from 86 TFs PBM data.

  Each model is stored in a MATLAB .mat file. The variable name of the linear-regression based model is 'b'.


```functions/```:
  stores dependant functions. 


### Manuscript
[Link](https://academic.oup.com/bioinformatics/article/33/14/2097/3059139)
