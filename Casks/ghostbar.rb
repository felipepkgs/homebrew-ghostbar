cask "ghostbar" do
  version "0.1.0"
  sha256 "a30aa94eae86f1e8a6c0de99b0d053f464ec45db76f5b5ab1251b74bba76a165"

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
