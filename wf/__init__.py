"""
Summarize all the preprocessing and down stream analysis for your metabolomics data.
"""
import subprocess
from pathlib import Path

from latch import small_task, workflow
from latch.types import LatchFile, LatchDir


#Might be for more than preprocessing
@small_task
def preprocessing(meta: LatchFile, samples: LatchFile, data: LatchFile, output_dir: str) -> LatchFile: # can it be string?

    # Define command and arguments
    command = 'Rscript'
    path2script = '/root/wf/MetaLINCS1.R'

    # Variable number of args in a list
    args = [meta.local_path, samples.local_path, data.local_path]

    # Build subprocess command to call rmd file with parameters
    cmd = [command, path2script] + args

    subprocess.run(cmd, check=True) #no more x = ig
    
    #figure out where r markdown path is and return it.... SO IN R MUST PLACE THE RMARKDOWN FILE IN THE SAME FOLDER AS THE RSCRIPT or something like that
    #Obtain the html file location from subprocess
    # html_file = Path(x.stdout)
    # html_file = Path(x.stdout.decode('utf-8')).resolve()
    

    #make html file a LatchFile and return it
    # return LatchFile(str(html_file), "latch:///MetaLINCS1.html")

    #obtain output directory from 
    local_output_dir = Path("/root/results").resolve() #results created in R file
    return LatchDir(str(local_output_dir), "latch:///" + output_dir) #still not sure what the 2 dirs for (local , remote)
    



# @small_task
# def sort_bam_task(sam: LatchFile) -> LatchFile:

#     bam_file = Path("covid_sorted.bam").resolve()

#     _samtools_sort_cmd = [
#         "samtools",
#         "sort",
#         "-o",
#         str(bam_file),
#         "-O",
#         "bam",
#         sam.local_path,
#     ]

#     subprocess.run(_samtools_sort_cmd)

#     return LatchFile(str(bam_file), "latch:///covid_sorted.bam")


#Images not supported in Latch markdown
@workflow
def MetaLINCS(meta: LatchFile, samples: LatchFile, data: LatchFile, output_dir: str) -> LatchFile:
    """This pipeline is designed to summarize all the preprocessing and down stream analysis for the metabolomics data.

    MetabolonR
    ----

    ![MetabolonR Workflow](workflowIM.png)

    Write some documentation about your workflow in
    markdown here:

    > Regular markdown constructs work as expected.

    # Heading

    * content1
    * content2

    __metadata__:
        display_name: MetaLINCS
        author:
            name: Fadhl Alakwaa, Zyad Shehadeh
            email: zyads@umich.edu
            github: 
        repository:
        license:
            id:

    Args:
        meta:
            Metadata annotation file for the experiment.

            __metadata__:
                display_name: Metadata File
        
        samples:
            Samples file.

            __metadata__:
                display_name: Samples File

        data:
            Metabolomics data file.

            __metadata__:
                display_name: Metabolomics Data File
    """
    return preprocessing( meta = meta, samples = samples, data = data, output_dir = output_dir)


#prolly need fix this... maybe i gotta uninstall some packages?
if __name__ == "__main__":
    MetaLINCS( meta = LatchFile("/root/data/meta.csv", "latch:///meta.csv"), samples = LatchFile("/root/data/samples.csv", "latch:///samples.csv"), data = LatchFile("/root/data/data.csv", "latch:///data.csv"), output_dir = "results")