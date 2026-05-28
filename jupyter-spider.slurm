#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --partition=normal

APPTAINER_IMAGE="${HOME}/eq-simulation/eq-simulation.sif"

# Bind all paths from host system within the container
_DIRS=`/usr/bin/ls -1 / | /usr/bin/awk '!/dev/' | /usr/bin/sed 's/^/\//g' `
export APPTAINER_BIND=`echo ${_DIRS} | /usr/bin/sed 's/ /,/g' `

# Use Python interpreter from the container image
PYTHON="apptainer run ${APPTAINER_IMAGE} python"

# Print message with instructions to set up port forwarding
PORT=` shuf -i 8400-9400 -n 1 `
echo "Run the following on your local machine: "
echo "ssh -i /path/to/private/ssh/key -N -L 8888:` hostname -s `:${PORT} ${USER}@spider.surf.nl"

# Start the Jupyter server
${PYTHON} \
  -m jupyterlab \
  --no-browser \
  --port=${PORT} \
  --ip=0.0.0.0
