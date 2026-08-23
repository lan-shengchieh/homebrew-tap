class Keyclean < Formula
  desc "Temporarily suppress macOS keyboard events while cleaning"
  homepage "https://github.com/lan-shengchieh/keyclean"
  url "https://github.com/lan-shengchieh/keyclean/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f061390ecc28899530c584194b594bc47fb0276b7c9d1e6426cdba6a18dcf7f0"
  license "MIT"
  head "https://github.com/lan-shengchieh/keyclean.git", branch: "main"

  depends_on :macos
  uses_from_macos "swift" => :build

  def install
    system "swiftc", "-O", "keyclean.swift", "-o", "keyclean"
    bin.install "keyclean"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/keyclean --version")
    assert_match "Control + Option + Command + U", shell_output("#{bin}/keyclean --help")
  end
end
