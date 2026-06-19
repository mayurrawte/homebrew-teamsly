cask "teamsly" do
  arch arm: "arm64", intel: "x64"

  version "0.6.2"

  on_arm do
    sha256 "631ccd113cc072cfd898c8756328e0741eacc77e860dcb58807e2a1fedcf674d"
    url "https://github.com/mayurrawte/teamsly/releases/download/v#{version}/Teamsly-#{version}-arm64.dmg",
        verified: "github.com/mayurrawte/teamsly/"
  end
  on_intel do
    sha256 "bdc1b5d0ef6a23e77970c191fe9af4044a3264a302bbd3b4072e92c53d0073e1"
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
