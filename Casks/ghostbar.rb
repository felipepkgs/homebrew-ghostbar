cask "ghostbar" do
  version "0.2.1"
  sha256 "e255c7287b967e0948ee544048899856ef2cb6d0ed381f92ed919f641d0220e9"

  url "https://github.com/felipepkgs/GhostBar/releases/download/v#{version}/GhostBar.app.zip"
  name "GhostBar"
  desc "Floating overlay that mirrors a dead-display Touch Bar"
  homepage "https://github.com/felipepkgs/GhostBar"

  depends_on macos: :ventura

  app "GhostBar.app"

  # Ad-hoc signed only (no Apple Developer ID) — see felipepkgs/GhostBar's
  # Scripts/build_app.sh for why. Clears the Gatekeeper quarantine flag so
  # users don't have to right-click > Open manually on first launch.
  #
  # ponytail: `postflight_steps`/`run` is the lint-preferred form, but its
  # `args:` values are passed straight through (`args.map(&:to_s)` in
  # Homebrew's install_steps.rb) with no base/template-token resolution —
  # only `run`'s `command:`, plus `chdir:`/`writable_paths:`, support that,
  # and none of those fit "an app path as an argument to xattr". `appdir` as
  # a bare call is genuinely undefined in that DSL (it's stripped down to
  # near-BasicObject). The plain `postflight` block still runs as real Ruby
  # against the live Cask::DSL, where `appdir` is a real method — that's the
  # only mechanism this use case actually has, not a workaround.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/GhostBar.app"]
  end

  zap trash: [
    "~/Library/Caches/com.felipepkgs.ghostbar",
    "~/Library/Preferences/com.felipepkgs.ghostbar.plist",
  ]
end
