#!/bin/bash

# First loop goes over all the points, should not be modified unless we change the emission grid as well
# Second loop controls how many runs for each emission point, can be modified

# Run 5 in parallel
for exp in {16..91} #91
do
    PID_LIST="";

    for run in {1..5}
    do
        python test_MPC_optimal_start_arg.py $run $exp & pid=$!;
        PID_LIST+=" $pid";
    done

    trap "kill $PID_LIST" SIGINT

    current_date_time="`date "+%Y-%m-%d %H:%M:%S"`";
    echo $current_date_time;

    echo "Point $exp processes have started";

    wait $PID_LIST

    current_date_time="`date "+%Y-%m-%d %H:%M:%S"`";
    echo $current_date_time;

    echo "Point $exp processes have completed";

    
done
