conda_prefix=$HOME/miniconda

wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
chmod +x miniconda.sh
bash miniconda.sh -b -p $conda_prefix
export PATH="$conda_prefix/bin:$PATH"
conda config --set always_yes yes --set changeps1 no
conda install gmt=${GMT_VERSION} -c conda-forge
