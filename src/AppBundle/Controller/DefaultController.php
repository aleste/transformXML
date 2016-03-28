<?php

namespace AppBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;


use Symfony\Component\Process\Process;
use Symfony\Component\Process\Exception\ProcessFailedException;

use Symfony\Component\HttpFoundation\BinaryFileResponse;


class DefaultController extends Controller
{
    
    /**
     * @Route("/", name="homepage")
     */
    public function indexAction(Request $request)
    {

       
        $form = $this->createFormBuilder()
            ->add('datos', FileType::class, array('label' => 'XML (datos)'))
            ->add('plantilla', FileType::class, array('label' => 'XSL (plantilla)'))
            ->add('send', SubmitType::class)
            ->getForm();

        /*if ($request->getMethod() === 'POST') {
            $form->handleRequest($request);
            if ($form->isValid()) {
                // data is an array with "name", "email", and "message" keys
                $data = $form->getData();
            }
        }*/

    
        return $this->render('default/index.html.twig', ['form' => $form->createView()]);    

    }

    /**
     * @Route("/html", name="to_html")
     */
    public function toHtmlAction(Request $request)
    {

        return $this->render('default/html.html.php', [
             'base_dir' => realpath($this->getParameter('kernel.root_dir').'/..'),
         ]);    

    }

    /**
     * @Route("/pdf", name="to_pdf")
     */
    public function toPdfAction(Request $request)
    {

        //Ejecuta Java class that convert XML-XSL into PDF.
        $process = new Process('java -cp lib/*:. Reporte2');
        $process->run();

        // executes after the command finishes
        if (!$process->isSuccessful()) {
            throw new ProcessFailedException($process);
        }

        echo $process->getOutput();

        return new BinaryFileResponse('reporte.pdf');

  

    }    

  
}
