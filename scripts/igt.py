import subprocess

# Function to create metadata
def create_metadata():
    # Create custom object for Product
    create_object_command = 'sf schema generate sobject -l "Product" -f'
    subprocess.run(create_object_command, shell=True)

    # Create picklist fields for Cabinet Type, Theme Type, and Segment Type
    create_picklist_field_command = 'sf schema generate field -l "Cabinet Type" -o force-app/main/default/objects/Product__c'
    subprocess.run(create_picklist_field_command, shell=True)

    create_picklist_field_command = 'sf schema generate field -l "Theme Type" -o force-app/main/default/objects/Product__c'
    subprocess.run(create_picklist_field_command, shell=True)

    create_picklist_field_command = 'sf schema generate field -l "Segment Type" -o force-app/main/default/objects/Product__c'
    subprocess.run(create_picklist_field_command, shell=True)

    # Create custom object for Component
    create_object_command = 'sf schema generate sobject -l "Component" -f'
    subprocess.run(create_object_command, shell=True)

    # Create fields for Component
    create_fields_command = 'sf schema generate field -l "Component Name" -o force-app/main/default/objects/Component__c'
    subprocess.run(create_fields_command, shell=True)

    create_fields_command = 'sf schema generate field -l "Price" -o force-app/main/default/objects/Component__c'
    subprocess.run(create_fields_command, shell=True)

    # Create custom object for Pricing
    create_object_command = 'sf schema generate sobject -l "Pricing" -f'
    subprocess.run(create_object_command, shell=True)

    # Create fields for Pricing
    create_fields_command = 'sf schema generate field -l "Product" -o force-app/main/default/objects/Pricing__c'
    subprocess.run(create_fields_command, shell=True)

    create_fields_command = 'sf schema generate field -l "Component" -o force-app/main/default/objects/Pricing__c'
    subprocess.run(create_fields_command, shell=True)

    create_fields_command = 'sf schema generate field -l "Price" -o force-app/main/default/objects/Pricing__c'
    subprocess.run(create_fields_command, shell=True)

    # Add additional fields as needed

# Main function to execute the script
def main():
    # Create metadata
    create_metadata()

if __name__ == '__main__':
    main()
