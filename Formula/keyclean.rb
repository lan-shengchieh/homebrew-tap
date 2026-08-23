class Keyclean < Formula
  desc "Temporarily suppress macOS keyboard events while cleaning"
  homepage "https://github.com/lan-shengchieh/keyclean"
  url "https://github.com/lan-shengchieh/keyclean/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f061390ecc28899530c584194b594bc47fb0276b7c9d1e6426cdba6a18dcf7f0"
  license "MIT"

  depends_on :macos

  def install
    system "/usr/bin/xcrun", "swiftc", "-O", "keyclean.swift", "-o", "keyclean"
    bin.install "keyclean"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/keyclean --version")
  end
end
