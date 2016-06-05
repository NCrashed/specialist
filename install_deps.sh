git clone https://github.com/fgaray/persist2er
cd persist2er
stack setup
stack install 

cd ..
git clone https://github.com/BurntSushi/erd.git
cd erd 
stack init --solver
stack setup 
stack install 

cd ..
stack install haskintex

sudo yum install java ghostscript