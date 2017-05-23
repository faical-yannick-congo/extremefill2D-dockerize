<<<<<<< HEAD
WORKDIR=${PWD}
cd ${HOME}/extremefill2D
git checkout 3ad19bd930d7
python setup.py develop
cd ${WORKDIR}

if ! [ -d ".smt" ]
        then
    smt init extremefill2D
=======
cp $HOME/extremefill2D/scripts/script.py $1
cp $HOME/extremefill2D/scripts/params.json $1
cp $HOME/extremefill2D/scripts/view.ipynb $1
cp $HOME/extremefill2D/scripts/run.sh $1

if ! [ -d "$1/.git" ]
then
    git init
fi

git add script.py params.json view.ipynb
git commit -m "next commit"

if ! [ -d "$1/.smt" ]
        then
    smt init smt-extremefill2D
>>>>>>> fe6ccb6677a0e56d4412c523b8ef012fe277beb5
    smt configure --executable=python --main=script.py
    smt configure -g uuid
    smt configure -c store-diff
    smt configure --addlabel=parameters
fi
<<<<<<< HEAD

smt run -t fig4test fig4/params.json totalSteps=10
=======
smt run -t testrun params.json totalSteps=10
>>>>>>> fe6ccb6677a0e56d4412c523b8ef012fe277beb5
