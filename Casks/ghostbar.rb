cask "ghostbar" do
  version "0.2.0"
  sha256 "531206c9a44ffdbd1a9f8eb44aa687a4d68a766a7f3cde00518d88eb33d8e657"

  url "https://github.com/felipepkgs/GhostBar/releases/download/v#{version}/GhostBar.app.zip"
  name "GhostBar"
  desc "Floating overlay that mirrors a dead-display Touch Bar"
  homepage "https://github.com/felipepkgs/GhostBar"

  depends_on macos: :ventura

  app "GhostBar.app"

  # Ad-hoc signed only (no Apple Developer ID) — see felipepkgs/GhostBar's
  # Scripts/build_app.sh for why. Clears the Gatekeeper quarantine flag so
  # users don't have to right-click > Open manually on first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", appdir/"GhostBar.app"]
  end

  zap trash: [
    "~/Library/Caches/com.felipepkgs.ghostbar",
    "~/Library/Preferences/com.felipepkgs.ghostbar.plist",
  ]
end
