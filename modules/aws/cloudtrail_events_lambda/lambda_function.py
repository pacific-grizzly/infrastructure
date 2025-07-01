
def lambda_handler(event, context):
    # This lambda should do a few things:
    # 1. If the event was Delete-type event, restore a previous version of the object that was just deleted
    # 2. If the policy was modified, apply a well-known policy instead, overwriting whatever manual changes had been made
    # 3. Profit
    print("Restoring bucket")
