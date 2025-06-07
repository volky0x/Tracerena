
import { useState } from 'react';
import { useAccount, useContractWrite } from 'wagmi';
import contractABI from '../abi/IdeaGraph.json';

const contractAddress = '0xYourDeployedContractAddress';

export default function Home() {
  const { address } = useAccount();
  const [contentURI, setContentURI] = useState('');

  const { write: postIdea } = useContractWrite({
    address: contractAddress,
    abi: contractABI,
    functionName: 'postIdea',
  });

  return (
    <div className="p-4">
      <h1 className="text-2xl font-bold">Arena Atlas</h1>
      <textarea
        className="w-full border mt-4 p-2"
        placeholder="Paste IPFS/Bundlr content URI here"
        value={contentURI}
        onChange={(e) => setContentURI(e.target.value)}
      />
      <button
        className="bg-blue-500 text-white px-4 py-2 mt-2"
        onClick={() => postIdea({ args: [contentURI] })}
      >
        Post Idea
      </button>
    </div>
  );
}
