cask "teamsly" do
  arch arm: "arm64", intel: "x64"

  version "0.5.0"

  on_arm do
    sha256 "acfd62efaf77638d2c700c4f87974e254a2b14148f81560c19e900139b5f0d71"
    url "https://github.com/mayurrawte/teamsly/releases/download/v#{version}/Teamsly-#{version}-arm64.dmg",
        verified: "github.com/mayurrawte/teamsly/"
  end
  on_intel do
    sha256 "181cf27df18c1a5fa9e7a00a5f2406193707edb85866acdec3b858e232412c83"
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
