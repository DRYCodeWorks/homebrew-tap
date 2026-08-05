cask "tacet" do
  version "0.1.1"
  sha256 "72fbbde28665aae8e2d18c73b711f2b3b7e2c80fb75a86b32e7804743a37f14e"

  url "https://github.com/DRYCodeWorks/tacet/releases/download/v#{version}/Tacet.zip",
      verified: "github.com/DRYCodeWorks/tacet/"
  name "Tacet"
  desc "Push-to-talk dictation that pastes the transcript at the cursor"
  homepage "https://github.com/DRYCodeWorks/tacet"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Tacet.app"

  # Deliberately NOT `depends_on formula: "whisper-cpp"`. One bundle plays two
  # roles: the menu-bar agent, and `tacet serve`, which is the only part that
  # needs whisper. Making it a hard dependency would build a large formula on
  # every laptop that is only ever a client, talking to a server on another
  # machine — the two-machine setup this is designed around.
  uninstall launchctl: [
    "com.drycodeworks.tacet",
    "com.drycodeworks.tacet-whisper",
  ]

  zap trash: [
    "~/.config/tacet",
    "~/Library/LaunchAgents/com.drycodeworks.tacet-whisper.plist",
    "~/Library/LaunchAgents/com.drycodeworks.tacet.plist",
  ]

  caveats do
    <<~EOS
      This cask installs the app bundle. Tacet still needs one-time setup to
      write its config and load its launchd agents:

        Server (the machine that transcribes — needs `brew install whisper-cpp`):
          ./install-server.sh    from a clone of the repo

        Client (the machine you dictate from):
          ./install-client.sh    from a clone of the repo

      Both detect this cask and use the bundle Homebrew installed rather than
      rebuilding one, so you do not end up with two copies and they will not
      re-sign a notarized app. Run either with --doctor to diagnose a boundary
      that is not working.

      Tacet needs Accessibility (to paste at the cursor) and Microphone
      permission. macOS only offers these when the app asks, so grant them at
      the first hotkey press — they cannot be pre-approved.

      Set `whisper.prompt` in ~/.config/tacet/config.toml to your own jargon.
      It is empty by default and is the cheapest accuracy win available.
    EOS
  end
end
