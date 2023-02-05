function upgrade --description 'Gets OS X Software Updates and update Homebrew and npm packages'
    sudo softwareupdate -i -a
    brew update
    brew upgrade --force --all
    brew cleanup
    npm install npm -g
    npm update -g
end
