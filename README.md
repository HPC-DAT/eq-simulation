# Material to setup EQ simulations on Spider

SSH to Spider, clone and access this repository:
```shell
ssh -i path/to/private/key username@spider.surf.nl
git clone https://github.com/HPC-DAT/eq-simulation.git .
cd eq-simulation
```

Download the Salvus binaries and create the license file (replace `USERNAME` and `PASSWORD` with the actual values):
```shell
wget -O salvus_downloader_linux https://get.mondaic.com/salvus_downloader_linux
chmod u+x salvus_downloader_linux
./salvus_downloader_linux --accept-eula --create-license-file --authentication "USERNAME:PASSWORD" --installation-directory ./salvus  --python-version Py311 --operating-system Linux  --microarchitecture X86_64 --release  LATEST  --get Salvus --get SalvusPy
```

Define the required dependencies via a conda environment file. We include here [an environment file](./environment.yml), which is based on the one provided as part of the Salvus [installation instructions](https://docs.mondaic.com/installation/platform_specific/linux) to which we have added jupyterlab.

The use of conda on Spider is discouraged (the large number of files in the environments puts pressure on the distributed filesystem). We thus set up an environment in a container image, using Apptainer. Build the image using:
```shell
apptainer build eq-simulation.sif apptainer.def
```

Submit now [the provided jobscript](./jupyter-spider.slurm) to the queue to start a JupyterLab on a compute node of Spider (note that you might have to adapt the path to the .SIF image file in the jobscript before submission):
```shell
sbatch jupyter-spider.slurm
```

When the job starts (you can check the submitted jobs with `squeue --me`), a file named `slurm-XXXXX.out` will be created in the same directory. The first few lines of the file will contain instructions to connect to the JupyterLab session from your machine. **The command needs to run on your local machine (not on Spider) and it does not produce any output**. The same file will also contain URLs of the form `http://127.0.0.1:8412/lab?token=....`. Copy the string that follows `token=` (this is the token to access the JupyterLab session). 

You can now access the JupyterLab session from your browser at http://localhost:8888 , using the access token to authenticate.


