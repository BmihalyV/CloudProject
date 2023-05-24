module "files" {
  source  = "./modules/files"
  content = "test"
 filename = "filename"
}
module "read" {
  source        = "./modules/read"
  read_variable = tostring(module.files.example_output[0])
}
locals {
  answers = file("modules/write/terraform.tfvars")
}  
 
module "write" {
  source        = "./modules/write"
  
  answer_1 = trim(split("=", split("\n", local.answers)[0])[1], "\"\n")
  answer_2 = trim(split("=", split("\n", local.answers)[1])[1], "\"\n")
  answer_3 = trim(split("=", split("\n", local.answers)[2])[1], "\"\n")
  answer_4 = trim(split("=", split("\n", local.answers)[3])[1], "\"\n")
  answer_5 = trim(split("=", split("\n", local.answers)[4])[1], "\"\n")
}
  
module "data" {
   source = "./modules/data"
   file_path = module.files.example_output[0]
   depends_on = [module.files]
}  

output "file_id" {
   value = module.data.file_id
 }
