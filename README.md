- 取得檔案
```
git clone https://github.com/grimreaperes00/ELK.git
git checkout yoyo
```
- 進入檔案下
```
cd ELK/AQUA-CARE-2025-June-main/AQUA-CARE-2025-June-main
```
- 執行腳本
```
bash tools/install_k3s_elk.sh
```
- Kibana跑在 5601 埠，帳號預設是 elastic，密碼要用下列指令取得
```
kubectl get secret elasticsearch-master-credentials -o jsonpath="{.data.password}" | base64 --decode
```
