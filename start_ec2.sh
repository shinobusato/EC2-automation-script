#!/bin/bash

INSTANCE_ID="i-00993bdcb31a91056"
REGION="ap-southeast-2"
LOG_FILE="/home/shinobu_sato/start_ec2.log"

# ログ出力先設定
exec >> $LOG_FILE 2>&1

# ログ関数
log() {
  LEVEL=$1
  MESSAGE=$2
  echo "$(date '+%Y-%m-%d %H:%M:%S') [$LEVEL] $MESSAGE"
}

log INFO "=== START PROCESS ==="

# 起動
log INFO "Starting EC2: $INSTANCE_ID"

aws ec2 start-instances \
  --instance-ids $INSTANCE_ID \
  --region $REGION

if [ $? -ne 0 ]; then
  log ERROR "Failed to start EC2"
  exit 1
fi

# 起動待ち
log INFO "Waiting for EC2 to be running"

aws ec2 wait instance-running \
  --instance-ids $INSTANCE_ID \
  --region $REGION

if [ $? -ne 0 ]; then
  log ERROR "EC2 did not reach running state"
  exit 1
fi

log INFO "EC2 is now running"

log INFO "=== END PROCESS ==="
