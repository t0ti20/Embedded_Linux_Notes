#!/bin/bash
<<comment
List Running Processes
Process Information
Kill a Process
Process Statistics
Real-time Monitoring
Search and Filter
Interactive Mode
Resource Usage Alerts
Logging
Configuration Options
comment
############################################
#             Configurations               #
############################################
Application_Name=$(basename "$0")

############################################
#             Configure Color              #
############################################
GREEN="0;32"
RED="1;31"
Print()
{
    Color=$1
    Text=$2
    echo -e "\e[${Color}m${Text}\e[0m"
}
############################################
#                 User Help                #
############################################
Usage_Help() 
{
    echo "Usage_Help: ${Application_Name} -l -h "
    echo "  -l          List All Running Processes."
    echo "  -i[PID]     List All Information About [PID]"
    echo "  -h          Help FoR Valid Options."
    exit 1
}
############################################
#             List All Process             #
############################################
List_Process()
{
    Print ${GREEN} "List All Process Information."
    ps aux | awk '{print $2 "\t" $3 "\t" $4 "\t" $11}'
}
############################################
#            Process Informaion            #
############################################
Process_Informaion()
{
    # Check if PID is provided
    if [ ! -e "/proc/${OPTARG}" ];
    then
        Print ${RED} "Process with PID ${OPTARG} does not exist."
        exit 1
    fi
    Print ${GREEN}  "List Information For Process ID -> ${OPTARG}."
    # List detailed information for the specified PID
    ps -p ${OPTARG} o pid,ppid,%cpu,%mem,user,stime,tname,time,cmd | tr -s ' ' $'\t'
}
############################################
#             Main Application             #
############################################
while getopts "hli:" Option
do
    case ${Option} in 
        l)
            List_Process
        ;;
        i)
            Process_Informaion 
        ;;
        h)
            Usage_Help
        ;;
        \?)
            Usage_Help
        ;;
        :)
            echo "Option -$OPTARG requires an argument."
            Usage_Help
            ;;
    esac
done
# Check if no options were provided
if [ $OPTIND -eq 1 ];
then
    echo "No options provided."
    Usage_Help
fi