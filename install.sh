#!/bin/bash
# Variabili per il Grassetto
bold=$(tput bold)
normal=$(tput sgr0)

# Verifica di essere root
if (( $EUID != 0 )); then
  clear -x
  printf "\\e[0;41m${bold}Attenzione! Per eseguire questo script suserve i privilegi di ROOT!${normal}\\e[0m\n\n"
  exit
fi

######################################################
########## SERVE PER ACCETTARE LE OPZIONI ############
######################################################
Help()
{
   # Display Help
   echo "Per installare i3CX usare la segeunte guida."
   echo
   echo "Esempio: ./install.sh -v"
   echo
   echo "Sintassi: ./install.sh <Opzione>"
   echo "Opzioni:"
   printf "\t -v    \\e[0;42m${bold}Accetti${normal}\\e[0m l'installazione. \n"
   printf "\t -n    \\e[0;41m${bold}Non acccetti${normal}\\e[0m l'installazione.\n"
   printf "\t -h    Mostra questa guida.\n"
   echo
}

Error()
{
   # Errore input inserito sbagliato
   printf "\\e[0;41m${bold}Errore: Input Non Valido!${normal}\\e[0m\n\n"
   echo "Per installare i3CX usare la segeunte guida: "
   echo
   echo "Esempio: ./install.sh -v"
   echo
   echo "Sintassi: ./install.sh <Opzione>"
   echo "Opzioni:"
   printf "\t -v    \\e[0;42m${bold}Accetti${normal}\\e[0m l'installazione. \n"
   printf "\t -n    \\e[0;41m${bold}Non acccetti${normal}\\e[0m l'installazione.\n"
   printf "\t -h    Mostra questa guida.\n"
   echo
}

Yes()
{
  # Esegue l'installazione
  clear -x
  printf "\\e[1;34mi3CX L'installaer per 3CX ☎️ creato per Byter 💻 \\e[0m V.1.0\n"
  printf "Benvenuto sull' installer di un centralino 3cx con questi servizi:"
  printf '\nCentralino 3CX V18 con le sue librerie per il corretto funzionameto.\n\n'
  printf 'Continuare? (Y/n): Y'

  # Aggiorna i repositori
  printf '\nSto aggiornando i repositori\n'
  apt update -y
  apt upgrade -y

  printf '\nInstallo Wget\n'
  apt install wget -y 

  printf '\nAggiungo chiave e file di installazione per il repository 3CX \n'
  wget -O- http://downloads-global.3cx.com/downloads/3cxpbx/public.key | sudo apt-key add - 
  apt install gnupg2 -y
  echo "deb http://downloads-global.3cx.com/downloads/debian buster main" | sudo tee /etc/apt/sources.list.d/3cxpbx.list


  printf '\nInstallo centralino 3CX\n'
  apt update -y
  apt upgrade -y
  sudo apt install -y net-tools dphys-swapfile
  sudo apt -y install 3cxpbx


  # Copiare file template per i telefoni fxs (cordless)
  printf '\nSto copiando i template per i telefoni FXS (cordelss) mancanti\n'
  cp -r template/fxs/* /var/lib/3cxpbx/Instance1/Data/Http/Templates/fxs/

 
  printf "\\e[0;42m${bold}Installazione completata con successo ☑️  !${normal}\\e[0m\n\n"

  printf "${bold}Usate un browser e inserite l'ip pubblico (se su hosting in cloud) o l'ip privato (se locale) usando la porta \\e[1;31m5015\\e[0m e \\e[1;31mL'HTTP\\e[0m ${normal} \n\n"

  printf "${bold}Developed by  \e]8;;https://github.com/roby8martin\e\\ \\e[0;34mroby8martin\\e[0m \e]8;;\e\\  for developers ${normal} \n\n"
}

No()
{
   # Non acceti l'installazione
   printf "\n\n\\e[0;41m${bold}Installazione ANNULLATA con successo ⚠️!${normal}\\e[0m\n\n"
   printf "${bold}Ciao👋!${normal}\n\n"
}

# Serve per eseguire il programma accettando le opzioni esterne -y -n -h
while getopts ":y :n :h" option; do
   case $option in
    y) # Accetti l'installazione
      Yes
    exit;;
    n) # Non accetti l'installazione
      No
    exit;;
    h) # Mostra Guida
      Help
    exit;;
    \?) # Opzione non valida
      Error
    exit;;
   esac
done


######################################################
########## SCRIPT CHE SI ESEGUE MANUALMENTE ##########
######################################################

# Programma che si esegue manualmente
clear -x
printf "\\e[1;34mi3CX L'installaer per 3CX ☎️ creato per Byter 💻 \\e[0m V.1.0\n"
printf "Benvenuto sull' installer di un centralino 3cx con questi servizi:"
printf '\nCentralino 3CX V18 con le sue librerie per il corretto funzionameto.\n\n'
printf 'Continuare? (Y/n):'

read RISPOSTA

if [ ${RISPOSTA} = "y" ] || [ ${RISPOSTA} = "Y" ]; then
  # Aggiorna i repositori
  # Aggiorna i repositori
  printf '\nSto aggiornando i repositori\n'
  apt update -y
  apt upgrade -y

  printf '\nInstallo Wget\n'
  apt install wget -y 

  printf '\nAggiungo chiave e file di installazione per il repository 3CX \n'
  wget -O- http://downloads-global.3cx.com/downloads/3cxpbx/public.key | sudo apt-key add - 
  apt install gnupg2 -y
  echo "deb http://downloads-global.3cx.com/downloads/debian buster main" | sudo tee /etc/apt/sources.list.d/3cxpbx.list


  printf '\nInstallo centralino 3CX\n'
  apt update -y
  apt upgrade -y
  sudo apt install -y net-tools dphys-swapfile
  sudo apt -y install 3cxpbx


  # Copiare file template per i telefoni fxs (cordless)
  printf '\nSto copiando i template per i telefoni FXS (cordelss) mancanti\n'
  cp -r template/fxs/* /var/lib/3cxpbx/Instance1/Data/Http/Templates/fxs/

 
  printf "\\e[0;42m${bold}Installazione completata con successo ☑️  !${normal}\\e[0m\n\n"

  printf "${bold}Usate un browser e inserite l'ip pubblico (se su hosting in cloud) o l'ip privato (se locale) usando la porta \\e[1;31m5015\\e[0m e \\e[1;31mL'HTTP\\e[0m ${normal} \n\n"

  printf "${bold}Developed by  \e]8;;https://github.com/roby8martin\e\\ \\e[0;34mroby8martin\\e[0m \e]8;;\e\\  for developers ${normal} \n\n"

else
  printf "\n\n\\e[0;41m${bold}Installazione ANNULLATA con successo ⚠️!${normal}\\e[0m\n\n"
  printf "${bold}Ciao👋!${normal}\n\n"
fi