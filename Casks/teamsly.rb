cask "teamsly" do
  arch arm: "arm64", intel: "x64"

  version "0.4.0"

  on_arm do
    sha256 "4719f2e16305c810e45c289f7e59526edc65ae690eae9809a2f043e90d33f35a"
    url "https://github.com/mayurrawte/teamsly/releases/download/v#{version}/Teamsly-#{version}-arm64.dmg",
        verified: "github.com/mayurrawte/teamsly/"
  end
  on_intel do
    sha256 "1d1f44ef84245ac622d7de477a4c21a7329d48d9c6e02cd3cdc6c9fa9e371167"
    url "https://github.com/mayurrawte/teamsly/releases/download/v#{version}/Teamsly-#{version}.dmg",
        verified: "github.com/mayurrawte/teamsly/"
  end

  name "Teamsly"
  desc "Open-source modern client for Microsoft Teams"
  homepage "https://github.com/mayurrawte/teamsly"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true

  # macOS 26+ Gatekeeper refuses to launch unsigned apps even when the
  # quarantine attribute has been cleared. An ad-hoc signature is enough to
  # satisfy the new check until we ship Apple Developer–notarized builds.
  preflight do
    staged_app = "#{staged_path}/Teamsly.app"
    system_command "/usr/bin/xattr",   args: ["-cr", staged_app], must_succeed: false
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", staged_app],
                   must_succeed: false
  end

  app "Teamsly.app"

  zap trash: [
    "~/Library/Application Support/Teamsly",
    "~/Library/Logs/Teamsly",
    "~/Library/Preferences/co.shipthis.teamsly.plist",
    "~/Library/Saved Application State/co.shipthis.teamsly.savedState",
  ]
end
