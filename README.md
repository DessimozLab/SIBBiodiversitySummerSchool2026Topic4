# SIBBiodiversitySummerSchool2026Topic4
Materials for the 2026 summer school

# Environment Setup Instructions

This course uses a Conda environment to install the required software.

## 1. Create the virtual environment

From the root directory of the repository, run:
```bash
conda install -n base -c conda-forge mamba
mamba env create -f Module1_AnnotationQuality/environmentT4.yml
```


alternatively...
```bash
python3 -m venv module1env

source module1env/bin/activate

pip install --upgrade pip

pip install -r requirements.txt
```
