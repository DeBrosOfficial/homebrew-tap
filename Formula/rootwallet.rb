# typed: false
# frozen_string_literal: true
class Rootwallet < Formula
  desc "RootWallet CLI — terminal wallet for EVM and Solana"
  homepage "https://rootwallet.io"
  url "https://registry.npmjs.org/@debros/root-cli/-/root-cli-0.107.5.tgz"
  sha256 "059f0cdefec776bda78a7ff11f8032f49ad969448479c1cf074af75b67595d52"
  version "0.107.5"
  license "MIT"

  depends_on "node"

  def install
    # dist/index.js is fully bundled (tsup noExternal) and has a node shebang,
    # so no npm install / node_modules is needed — just expose it as `rw`.
    libexec.install "dist", "package.json"
    (libexec/"dist/index.js").chmod 0755
    bin.install_symlink libexec/"dist/index.js" => "rw"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rw --version")
  end
end
