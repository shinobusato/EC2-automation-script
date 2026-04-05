#!/bin/bash

INSTANCE_ID="i-00993bdcb31a91056"
REGION="ap-southeast-2"
LOG_FILE="/home/shinobu_sato/stop_ec2.log"

# ログ出力先設定
exec >> $LOG_FILE 2>&1

# ログ関数
log() {
  LEVEL=$1
  MESSAGE=$2
  echo "$(date '+%Y-%m-%d %H:%M:%S') [$LEVEL] $MESSAGE"
}

log INFO "=== STOP PROCESS ==="

# 停止実行
log INFO "Stopping EC2: $INSTANCE_ID"

aws ec2 stop-instances \
  --instance-ids $INSTANCE_ID \
  --region $REGION

if [ $? -ne 0 ]; then
  log ERROR "Failed to stop EC2"
  exit 1
fi

# 停止待ち
log INFO "Waiting for EC2 to be stopped"

aws ec2 wait instance-stopped \
  --instance-ids $INSTANCE_ID \
  --region $REGION

if [ $? -ne 0 ]; then
  log ERROR "EC2 did not reach stopped state"
  exit 1
fi

log INFO "EC2 is now stopped"

log INFO "=== END PROCESS ==="
