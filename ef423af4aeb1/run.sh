if ! [ -d "$1/.git" ]
then
    cp $HOME/extremefill2D/scripts/script.py $1
    cp $HOME/extremefill2D/scripts/params.json $1
    cp $HOME/extremefill2D/scripts/view.ipynb $1
    git init
    git add script.py params.json view.ipynb
    git commit -m "initial commit"
fi
if ! [ -d "$1/.smt" ]
        then
    smt init smt-extremefill2D
    smt configure --executable=python --main=script.py
    smt configure -g uuid
    smt configure -c store-diff
    smt configure --addlabel=parameters
fi
smt run -t testrun params.json totalSteps=10
