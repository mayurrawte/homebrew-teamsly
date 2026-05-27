cask "teamsly" do
  arch arm: "arm64", intel: "x64"

  version "0.3.0"

  on_arm do
    sha256 "da1d506ed35b3965aafe0578464a9e6c16d6d7bd44331a6ce95b9b6ca4a0afe3"
    url "https://github.com/mayurrawte/teamsly/releases/download/v#{version}/Teamsly-#{version}-arm64.dmg",
        verified: "github.com/mayurrawte/teamsly/"
  end
  on_intel do
    sha256 "f469a8c5bf6b289489c7dd3cf3353d73a7fdbcd464a2f7a7b4f1793dec6915f6"
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
