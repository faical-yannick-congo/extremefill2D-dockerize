COUNTER=0
for BULKSUPPRESSOR in "0.006" "0.012"
do
<<<<<<< HEAD
    for APPLIEDPOTENTIAL in "-0.16" "-0.18" "-0.20" "-0.22" "-0.24"
    do
        smt run -t provisional2 provisional/params.json totalSteps=2000 appliedPotential="${APPLIEDPOTENTIAL}" bulkSuppressor="${BULKSUPPRESSOR}" > out.${COUNTER} 2>&1 &
=======
    # for APPLIEDPOTENTIAL in "-0.16" "-0.18" "-0.20" "-0.22"
    for APPLIEDPOTENTIAL in "-0.24" "-0.26" "-0.28" "-0.30" "-0.35" "-0.4"
    do
        smt run -t provisional1 params.json totalSteps=2000 appliedPotential="${APPLIEDPOTENTIAL}" bulkSuppressor="${BULKSUPPRESSOR}" > out.${COUNTER} 2>&1 &
>>>>>>> fe6ccb6677a0e56d4412c523b8ef012fe277beb5
        let COUNTER++
    done
done
