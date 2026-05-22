class Yolomancer < Formula
  desc "Agentic coding CLI for yolomancer"
  homepage "https://github.com/dennisvink/yolomancer"
  version "0.1.6"
  license "MIT"

  release_tag = "v#{version}"

  on_macos do
    on_arm do
      url "https://github.com/dennisvink/yolomancer/releases/download/#{release_tag}/yolomancer-darwin-arm64-#{version}"
      sha256 :no_check
    end

    on_intel do
      url "https://github.com/dennisvink/yolomancer/releases/download/#{release_tag}/yolomancer-darwin-amd64-#{version}"
      sha256 :no_check
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/dennisvink/yolomancer/releases/download/#{release_tag}/yolomancer-linux-amd64-#{version}"
      sha256 :no_check
    end

    on_arm do
      url "https://github.com/dennisvink/yolomancer/releases/download/#{release_tag}/yolomancer-linux-arm64-#{version}"
      sha256 :no_check
    end
  end

  def install
    binary_name =
      if OS.mac?
        Hardware::CPU.arm? ? "yolomancer-darwin-arm64-#{version}" : "yolomancer-darwin-amd64-#{version}"
      elsif OS.linux?
        Hardware::CPU.arm? ? "yolomancer-linux-arm64-#{version}" : "yolomancer-linux-amd64-#{version}"
      else
        odie "Unsupported platform for yolomancer"
      end

    source_binary = buildpath/binary_name
    odie "Expected prebuilt binary missing: #{source_binary}" unless source_binary.exist?

    bin.install source_binary => "yolomancer"
    chmod 0755, bin/"yolomancer"
  end

  test do
    assert_match "Agentic coding CLI for yolomancer", shell_output("#{bin}/yolomancer --help")
  end
end
