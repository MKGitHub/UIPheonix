#
# Please see the README.md for instructions.
#


cat Sources/*.swift > SingleFileSource/UIPheonix.swift

echo "// UIPheonix 2.0.1" > /tmp/UIPheonix_temp
echo "" >> /tmp/UIPheonix_temp
cat SingleFileSource/UIPheonix.swift >> /tmp/UIPheonix_temp
cp /tmp/UIPheonix_temp SingleFileSource/UIPheonix.swift


#…
