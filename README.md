# SIBBiodiversitySummerSchool2026Topic4
Materials for the 2026 summer school

# Environment Setup Instructions

This course uses a Python virtual environment (`venv`) to install the required software.

## 1. Create the virtual environment

From the root directory of the repository, run:
```bash
conda install -n base -c conda-forge mamba
mamba env create -f environment.yml
```


alternatively...
```bash
python3 -m venv SIBBSSchoolT4Env

source SIBBSSchoolT4Env/bin/activate

pip install --upgrade pip

pip install -r requirements.txt
```

## to run busco
```bash
docker pull ezlabgva/busco:v6.0.0_cv1
docker run -u $(id -u) -v $(pwd):/busco_wd ezlabgva/busco:v6.0.0_cv1
```