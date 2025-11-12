/**
 * Global App Configuration
 * 
 * Wraps entire app with WagmiProvider for wallet management
 * Supports ZK Proof generation and verification on Arbitrum Sepolia
 */

import type { AppProps } from "next/app";
import { useState, useEffect } from "react";
import { WagmiProvider as WagmiProviderOriginal } from "wagmi";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { RainbowKitProvider, getDefaultConfig } from "@rainbow-me/rainbowkit";
import { arbitrumSepolia } from "wagmi/chains";
import "@rainbow-me/rainbowkit/styles.css";
import "../styles/globals.css";

// Create wagmi config for Arbitrum Sepolia (ZK Proof chain)
const config = getDefaultConfig({
  appName: "ZK Proof Demo",
  projectId: process.env.NEXT_PUBLIC_WALLET_CONNECT_PROJECT_ID || "3a8170812b534d0ff9d794f19a901d64",
  chains: [
    arbitrumSepolia, // For ZK Proof generation and verification
  ],
  ssr: false,
});

export default function App({ Component, pageProps }: AppProps) {
  // Create React Query client per-request to avoid sharing state between SSR requests
  const [queryClient] = useState(() => new QueryClient());
  const [mounted, setMounted] = useState(false);

  // Ensure providers only render on client-side to prevent hydration errors
  useEffect(() => {
    setMounted(true);
  }, []);

  if (!mounted) {
    return null;
  }

  return (
    <WagmiProviderOriginal config={config}>
      <QueryClientProvider client={queryClient}>
        <RainbowKitProvider>
          <Component {...pageProps} />
        </RainbowKitProvider>
      </QueryClientProvider>
    </WagmiProviderOriginal>
  );
}
