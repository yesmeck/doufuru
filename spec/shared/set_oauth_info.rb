shared_context "set oauth info" do
  let(:oauth_token) { "faketoken" }
  let(:oauth_header) { {"Authorization" => "Bearer #{oauth_token}"} }
end
