Download Salvus binaries:
```
# define authentication credentials to download salvus binaries
export AUTHENTICATION="USERNAME:PASSWORD"
bash get-salvus-binaries.bsh
```

Get the default salvus environment files:
```
curl https://docs.mondaic.com/environment-py311.yml -o environment.yml
```
Edit the file to add the extra dependencies (e.g. jupyterlab).

Build the apptainer image:
```
apptainer build salvus.sif apptainer.def
```
