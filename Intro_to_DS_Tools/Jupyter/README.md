## How to install Python and Jupyter notebooks

#### Download Miniconda (Python 3.7 distribution):  https://conda.io/miniconda.html

##### Follow installation instructions:  https://conda.io/docs/install/quick.html
<br>

Windows: open a Command Prompt window.

Mac/Linux: Open a terminal. If not already active, enter bash shell. Stay in bash shell from now on.

. > bash
<br>
<br>
#### Make sure that conda is in the PATH variable.

Mac/Linux: $ which conda

Windows: > where conda
<br>
<br>
#### Install needed packages and put everything into environment called "geocode".
 
$ conda config --add channels conda-forge

$ conda create --name geocode python=3 numpy scipy pandas jupyter
<br>
<br>
#### Activate geocode environment. Note the "(geocode)" prefix in the bash shell prompt from now on.

$ source activate geocode
<br>
<br>
#### Create and enter working directory. 

$ mkdir workdir

$ cd workdir
<br>
<br>
#### Run installation tests.
##### Download installation test package conda_installation_test.zip


##### Unpack conda_installation_test.zip:  


$ unzip conda_installation_test.zip
(in Windows right-click on .zip, then "Extract All")


##### Run installation test  

Mac/Linux:$ ./test_installation.sh

Windows: > python test_installation.py
<br>
Note that the following message can be ignored: 

_Gtk-Message: Failed to load module "canberra-gtk-module"_
<br>
<br>
##### Running the installation test will tell you if all needed packages were correctly installed. As a final check, a jupyter notebook should open up in your brower. On Windows, you have to do this final step manually via the following command:

. > jupyter notebook
