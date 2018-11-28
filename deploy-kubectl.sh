
sudo apt-get install apt-transport-https lsb-release software-properties-common -y

sudo apt-key --keyring /etc/apt/trusted.gpg.d/Microsoft.gpg adv \
     --keyserver packages.microsoft.com \
     --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF
	 
sudo apt-get update

sudo apt-get install azure-cli

sudo az login -u asad.akram@contour-software.com -p Abcd12345678@

sudo az aks get-credentials --resource-group pdfservice112-rg --name pdfservice112-cluster
