export PATH=/opt/homebrew/bin:$PATH
export DEFAULT_USER="cenglisch"
export ZSH="/Users/cenglisch/.oh-my-zsh"

ZSH_THEME="agnoster"

export PATH="/usr/local/opt/mysql-client/bin:$PATH"

plugins=(git macos docker docker-compose mysql)

source $ZSH/oh-my-zsh.sh

alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias ga="git add"
alias gcm="git commit -m"
alias gph="git push"
alias ll="ls -la -G"
alias g="git"
alias gp="git pull"
alias gcl='git checkout -'
alias zshconfig="idea ~/.zshrc"
alias install="brew install"
alias uninstall="brew uninstall"
alias hmp="cd ~/Develop/management-platform/"
alias hmp-backend-impl="hmp && cd backend/src/main/java/de/haegerconsulting"
alias hmp-backend-test="hmp && cd backend/src/test/java/de/haegerconsulting"
alias cm="cd ~/Develop/CompanyManagement/"


function gamp() {
    if [[ -z $(git status -s) ]]; then
        echo "Es liegen keine ungespeicherten Änderungen im Arbeitsverzeichnis vor."
        return 1
    fi

    local branch_name=$(git rev-parse --abbrev-ref HEAD)

    git add .
    git commit -m "$branch_name"
    git push
}

copy_file_contents_to_clipboard() {
  local filenames=("$@")

  # Temporäre Datei zum Speichern des zusammengeführten Inhalts
  local merged_file="/tmp/merged_file.txt"

  # Zusammenführen des Inhalts der Dateien in die temporäre Datei
  for filename in "${filenames[@]}"; do
    cat "$filename" >> "$merged_file"
  done

  # Kopieren des Inhalts der temporären Datei in die Zwischenablage
  cat "$merged_file" | pbcopy

  echo "Inhalt der Dateien erfolgreich in die Zwischenablage kopiert."

  # Temporäre Datei löschen
  rm "$merged_file"
}

copy_files_in_folder_to_clipboard() {
  local folder_path="$1"

  # Überprüfen, ob der Ordner existiert
  if [[ ! -d "$folder_path" ]]; then
    echo "Der angegebene Pfad ist kein Ordner."
    return 1
  fi

  # Überprüfen, ob der Ordner Unterordner enthält
  if [[ $(find "$folder_path" -mindepth 1 -type d | wc -l) -gt 0 ]]; then
    echo "Der Ordner enthält Unterordner und kann nicht kopiert werden."
    return 1
  fi

  # Anzahl der Dateien im Ordner zählen
  local file_count=$(find "$folder_path" -maxdepth 1 -type f | wc -l)

  # Überprüfen, ob die Anzahl der Dateien im Ordner 10 oder weniger beträgt
  if [[ $file_count -gt 10 ]]; then
    echo "Es gibt mehr als 10 Dateien im Ordner. Kopiervorgang abgebrochen."
    return 1
  fi

  # Temporäre Datei zum Speichern des zusammengeführten Inhalts
  local merged_file="/tmp/merged_file.txt"

  # Zusammenführen des Inhalts der Dateien im Ordner in die temporäre Datei
  find "$folder_path" -maxdepth 1 -type f -exec cat {} \; > "$merged_file"

  # Kopieren des Inhalts der temporären Datei in die Zwischenablage
  cat "$merged_file" | pbcopy

  echo "Inhalt der Dateien im Ordner erfolgreich in die Zwischenablage kopiert."

  # Temporäre Datei löschen
  rm "$merged_file"
}

function md() {
	mkdir -p "$@" && cd "$@"
}

function docker_reset(){
   docker system prune --all;
   docker volume rm $(docker volume ls -q);
}
