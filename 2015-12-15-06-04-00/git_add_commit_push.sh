#This function when added to ~/.bashrc_profile will allow you to use
#the command 'push "Commit message"' to lazily push your repo to your git server

push() {
    #Add commit and push
    git add *
    git commit -a -m "$1"
    git push
}