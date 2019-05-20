wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
chmod +x miniconda.sh
bash miniconda.sh -b -p $conda_prefix
conda config --set always_yes yes --set changeps1 no
conda config --prepend channels conda-forge
if [ "$GMT_VERSION" == "5.4.5" ]; then
    conda install gmt=${GMT_VERSION}
elif [ "$GMT_VERSION" == "6.0.0" ]; then
    conda install gmt=${GMT_VERSION} -c conda-forge/label/dev
else
    echo "GMT_VERSION not specified"
fi
pip install -r requirements.txt
